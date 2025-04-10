"""migrate to separated ac validaton

Revision ID: 00a26df416e1
Revises: c7f0b8bcb220
Create Date: 2025-04-10 20:42:03.631569

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '00a26df416e1'
down_revision: Union[str, None] = 'c7f0b8bcb220'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.add_column("pilots",sa.Column("validateAcRegistration", sa.Boolean, nullable=False, server_default="1"))
    op.add_column("pilots",sa.Column("validateAcPilotlicense", sa.Boolean, nullable=False, server_default="1"))
    op.drop_column("pilots","acIsUtmOperator")

def downgrade() -> None:
    op.add_column("pilots",sa.Column("acIsUtmOperator", sa.Boolean, nullable=False, server_default="1"))
    op.drop_column("pilots","validateAcRegistration")
    op.drop_column("pilots","validateAcPilotlicense")
