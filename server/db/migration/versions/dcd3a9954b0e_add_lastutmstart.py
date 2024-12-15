"""add lastutmstart and lastutmend

Revision ID: dcd3a9954b0e
Revises: faf105487df8
Create Date: 2024-12-15 23:54:37.166774

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'dcd3a9954b0e'
down_revision: Union[str, None] = 'faf105487df8'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.add_column(
        'flightsessions',
        sa.Column('utmlaststart', sa.DateTime, nullable=True)
    )

def downgrade() -> None:
    op.drop_column('flightsessions','utmlaststart')
